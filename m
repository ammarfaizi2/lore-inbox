Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751631AbWJMMCI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751631AbWJMMCI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 08:02:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751634AbWJMMCH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 08:02:07 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:49470 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751624AbWJMMCG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 08:02:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=pnZbBpR1upAhybBdCPIcYGsZ0FvLwA9PCe4GBPSutj4rQJ+vufeXb0kQUESt45OEK7P4m+LfLG2Sq+NQ0d7X+4YpBiMrGsuiLQkTrjh1WnQxZMjUsBWN/CZaKDhJwOFcF+BMnVBMAyXi8BEX4F3PVIBTf4AiIa3CORpN/8dixHI=
Message-ID: <84144f020610130502o4ccfe30egb7c15c022f9c224f@mail.gmail.com>
Date: Fri, 13 Oct 2006 15:02:03 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Josef Jeff Sipek" <jsipek@cs.sunysb.edu>
Subject: Re: [PATCH 0 of 2] Stackfs: generic stackable filesystem helper functions
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org,
       hch@infradead.org, viro@ftp.linux.org.uk, linux-fsdevel@vger.kernel.org,
       ezk@cs.sunysb.edu, mhalcrow@us.ibm.com
In-Reply-To: <patchbomb.1160738328@thor.fsl.cs.sunysb.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <patchbomb.1160738328@thor.fsl.cs.sunysb.edu>
X-Google-Sender-Auth: d9467a65f1930feb
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

On 10/13/06, Josef Jeff Sipek <jsipek@cs.sunysb.edu> wrote:
> The following patches introduce stackfs_copy_* functions. These functions
> copy inode attributes (such as {a,c,m}time, mode, etc.) from one inode to
> another.

Looks ok to me. Thanks!
