Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750733AbWJMIFx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750733AbWJMIFx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 04:05:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750773AbWJMIFx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 04:05:53 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:44505 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750733AbWJMIFv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 04:05:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=Z3K467XlS8Rl+HwKPR6kMJEEFaMIsuC76aXjXoXK1jHHt8oh+cCP/pmhfPfP0x3ibDq+hz3DnQoOTCDuZQh7b8gL+0oJoXxpMDSLsmrhUELf5XJGQp1YEoj1cArbJJDHvLLmwxV3u+OM/brFYKoTr4Oty4s46lbYN9/dTDTVE3w=
Message-ID: <84144f020610130105uf2872b6g7ab44906dd530ef2@mail.gmail.com>
Date: Fri, 13 Oct 2006 11:05:50 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Josef Jeff Sipek" <jsipek@cs.sunysb.edu>
Subject: Re: [PATCH 20 of 23] Unionfs: Internal include file
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       torvalds@osdl.org, akpm@osdl.org, hch@infradead.org,
       viro@ftp.linux.org.uk, mhalcrow@us.ibm.com,
       phillip@hellewell.homeip.net
In-Reply-To: <84144f020610130102p4414f91fv9e2e4bee64690a16@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <patchbomb.1160197639@thor.fsl.cs.sunysb.edu>
	 <4a0655b52aef552fe558.1160197659@thor.fsl.cs.sunysb.edu>
	 <84144f020610130102p4414f91fv9e2e4bee64690a16@mail.gmail.com>
X-Google-Sender-Auth: b024944ce44749ad
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/13/06, Pekka Enberg <penberg@cs.helsinki.fi> wrote:
> Ecryptfs has the exact same bits. Please consolidate to common code.

Btw, now would be a good time to do fs/stackfs/ as suggested by hch to
the ecryptfs devs.
