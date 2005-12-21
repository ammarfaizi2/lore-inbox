Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932484AbVLUSHi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932484AbVLUSHi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 13:07:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751155AbVLUSHi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 13:07:38 -0500
Received: from wproxy.gmail.com ([64.233.184.205]:23464 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751154AbVLUSHh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 13:07:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lsOODFI+eS7WF3Eps0UGCEY4AoOuMKhiGntrBtUCwliQ4WaBPWPaiGRH/AbpJrut4bu6fDQH0/pH9ATupyC1BUhLb1EwfZ0AKibvuBLgYanKTCTwyLWAPBJG/HmeJiZam7hU8zAQ8TdQvg8F13ITnb6bG4PViq0AplxuwyvAXNM=
Message-ID: <9a8748490512211007v1b29b8dv2720886ca344e664@mail.gmail.com>
Date: Wed, 21 Dec 2005 19:07:36 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Jie Zhang <jzhang918@gmail.com>
Subject: Re: Question on the current behaviour of malloc () on Linux
Cc: linux-kernel@vger.kernel.org, lars.friedrich@wago.com
In-Reply-To: <9a8748490512211005u40ca4c7dv41044827544f97fa@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <6f48278f0512210936y25169c37t9fb7eb13fef3a97d@mail.gmail.com>
	 <9a8748490512211005u40ca4c7dv41044827544f97fa@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/21/05, Jesper Juhl <jesper.juhl@gmail.com> wrote:

> The final value of 2 means "Always overcommit" - In this mode the

This is a mistake ofcourse, I meant to say :

        The final value of 2 means "Don't overcommit"



--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
