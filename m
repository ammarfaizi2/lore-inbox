Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268133AbUHKRjS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268133AbUHKRjS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 13:39:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268135AbUHKRjS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 13:39:18 -0400
Received: from mx1.redhat.com ([66.187.233.31]:47081 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268133AbUHKRjR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 13:39:17 -0400
Date: Wed, 11 Aug 2004 13:39:13 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@dhcp83-102.boston.redhat.com
To: "Konstantin G. Khlebnikov" <c00nst@ezmail.ru>
cc: linux-kernel@vger.kernel.org
Subject: Re: [QUESTION] shift pages in mmap
In-Reply-To: <875636570.20040811124415@ezmail.ru>
Message-ID: <Pine.LNX.4.44.0408111339040.23161-100000@dhcp83-102.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Aug 2004, Konstantin G. Khlebnikov wrote:

>    how implement fast page alligned shift (cyclic rotate)
>    pages in anonymous mmap ?

Do you mean mremap(2) ?

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

