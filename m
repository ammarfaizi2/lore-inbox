Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261221AbVCACtO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261221AbVCACtO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 21:49:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261223AbVCACtO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 21:49:14 -0500
Received: from web50204.mail.yahoo.com ([206.190.38.45]:42666 "HELO
	web50204.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261221AbVCACtF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 21:49:05 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=JbkaV524n7eTTO1bvWFnuBiT+OJzGABTsYY8N0IWb1ZNEjL+2o0dIJQKjDyA9DxnmkUFp6yvq2+v7Eddzh8sNfh/AUhCTaf7mqNixYmDA8bmP2qN6a6mau2xkA/ED22L7WVJ9Ct0IPUeuN4abF0/SemYPxdjAkwQh20SjibNwgU=  ;
Message-ID: <20050301024904.48460.qmail@web50204.mail.yahoo.com>
Date: Mon, 28 Feb 2005 18:49:04 -0800 (PST)
From: Johan Braennlund <johan_brn@yahoo.com>
Subject: Re: ALPS touchpad not seen by 2.6.11 kernels
To: linux-kernel@vger.kernel.org
In-Reply-To: <200502252217.16410.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After applying your patch, I can confirm that the kernel detects the
touchpad without the i8042.noacpi option. Thanks!

- Johan



		
__________________________________ 
Do you Yahoo!? 
Yahoo! Mail - Helps protect you from nasty viruses. 
http://promotions.yahoo.com/new_mail
