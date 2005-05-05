Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261768AbVEEBJ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261768AbVEEBJ4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 21:09:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261782AbVEEBJ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 21:09:56 -0400
Received: from mx1.redhat.com ([66.187.233.31]:22202 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261768AbVEEBJz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 21:09:55 -0400
Date: Wed, 4 May 2005 21:09:49 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Dave Hansen <haveblue@us.ibm.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] update SubmittingPatches to clarify attachment
 policy
In-Reply-To: <20050504170156.87F67CE5@kernel.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.61.0505042109020.18390@chimarrao.boston.redhat.com>
References: <20050504170156.87F67CE5@kernel.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 May 2005, Dave Hansen wrote:

> Plus, a plain/text attachment message saved to a file can go
> into 'patch' the same way that an inline one can.

The problem is replying to an attachment.  The reason why having
the patch in the main mail body is good is that it gets quoted
by the email software and you can easily reply to individual
parts of the patch.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
