Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262494AbVCBWJc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262494AbVCBWJc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 17:09:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262499AbVCBWIZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 17:08:25 -0500
Received: from rproxy.gmail.com ([64.233.170.193]:49071 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262485AbVCBWEd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 17:04:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=o3C/5XKLIGp70WkBSmO/lS97Szc9yyUeUP7YwTangDtf//IDVJ8kaCXwIl00AkXrzAAn3nELAxQQDpqt+PukBO3J1Mma6eCDtIWmDjKNpcmUkJN944O7fpZ+BBkTSSrJr3F88BBedFH6NtCeYWCVCEg8/RG5+RYD4XP/G6/MW6o=
Message-ID: <d120d5000503021404187c5629@mail.gmail.com>
Date: Wed, 2 Mar 2005 17:04:30 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Joshua Hudson <jwhudson@hornet.csc.calpoly.edu>
Subject: Re: Bug report -- keyboard not working Linux 2.6.11 on Inspiron 1150
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.44.0503021324200.25652-100000@hornet>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <Pine.GSO.4.44.0503021324200.25652-100000@hornet>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Mar 2005 13:26:18 -0800 (PST), Joshua Hudson
<jwhudson@hornet.csc.calpoly.edu> wrote:
> No obvous reason. Works fine with kernel 2.6.10

Does it work with i8042.noacpi kernel boot parameter?

-- 
Dmitry
