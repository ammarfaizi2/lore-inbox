Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422663AbWJRUHv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422663AbWJRUHv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 16:07:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422808AbWJRUHv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 16:07:51 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:54321 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1422663AbWJRUHf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 16:07:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=UilPx1JuW88vp6lRIbsCEVoon1m41GxoWH7iinNj37Jx3Z8wQGzp5Xv6o9TF/m3dTnmyYhFiurEqZ5TbjBFXDHHLfxBHwXmZlSrAApAA8rs1icU6pX2Q5qvvLJUzmJLkrYxs+ul1+uVX4PcsKcuC/7I61MHlVeGNstAnGxio4vo=
Message-ID: <84144f020610181307r7566aa2bp3d7f31388574d457@mail.gmail.com>
Date: Wed, 18 Oct 2006 23:07:33 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Russell Cattelan" <cattelan@thebarn.com>
Subject: Re: Re: [xfs-masters] Re: [PATCH] fs/xfs: Handcrafted MIN/MAX macro removal
Cc: "Amol Lad" <amol@verismonetworks.com>,
       "linux kernel" <linux-kernel@vger.kernel.org>, xfs@oss.sgi.com
In-Reply-To: <1161193885.5723.168.camel@xenon.msp.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1161169068.20400.149.camel@amol.verismonetworks.com>
	 <1161193885.5723.168.camel@xenon.msp.redhat.com>
X-Google-Sender-Auth: c8bcb055ea22d5ca
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/18/06, Russell Cattelan <cattelan@thebarn.com> wrote:
> This change doesn't seem to do anything?

It kills useless wrappers from kernel code making it easier to read
and maintain for _Linux_ developers.
