Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261871AbTJASXK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 14:23:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261943AbTJASXK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 14:23:10 -0400
Received: from windsormachine.com ([206.48.122.28]:63633 "EHLO
	router.windsormachine.com") by vger.kernel.org with ESMTP
	id S261871AbTJASXH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 14:23:07 -0400
Date: Wed, 1 Oct 2003 14:23:04 -0400 (EDT)
From: Mike Dresser <mdresser_l@windsormachine.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [ACPI] p2b-ds blacklisted?
In-Reply-To: <blen4v$a42$1@sea.gmane.org>
Message-ID: <Pine.LNX.4.56.0310011421530.2483@router.windsormachine.com>
References: <blen4v$a42$1@sea.gmane.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
X-scanner: scanned by Inflex 1.0.12.3 - (http://pldaniels.com/inflex/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Oct 2003, [ISO-8859-15] Sven Köhler wrote:

> Hi,
>
> my P2B-DS is blacklisted and the kernel forced acpi=ht. i wonder why
> because P2B-D is not blacklisted.

Well, I remember having issues with the P2B-D boards under Windows, in
that the second cpu would stay at 100% cpu usage in task manager.
Suggested fix was a hardware modification that ASUS would perform, or the
user could do themselves.

Probably unrelated :)

Mike
