Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264001AbTBJHTT>; Mon, 10 Feb 2003 02:19:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264617AbTBJHTS>; Mon, 10 Feb 2003 02:19:18 -0500
Received: from webmail17.rediffmail.com ([203.199.83.27]:57295 "HELO
	rediffmail.com") by vger.kernel.org with SMTP id <S264001AbTBJHTS>;
	Mon, 10 Feb 2003 02:19:18 -0500
Date: 10 Feb 2003 07:35:58 -0000
Message-ID: <20030210073558.12280.qmail@webmail17.rediffmail.com>
MIME-Version: 1.0
From: "Nandakumar  NarayanaSwamy" <nanda_kn@rediffmail.com>
Reply-To: "Nandakumar  NarayanaSwamy" <nanda_kn@rediffmail.com>
To: "David Woodhouse" <dwmw2@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Re: Re: File systems in embedded devices
Content-type: text/plain;
	format=flowed
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>No, I was being sarcastic. There's no text below your quotation 
>in this
>mail from you either. It's all at the top. Please don't do 
>that.
>

Thank you very much David.
I was making mistakes all these days. Thank you very much 
really.

>If you really only need it to be read-only, and assuming NOR 
>flash, then
>cramfs on a flash device sounds like a sane option. If you have 
>NAND
>flash then it's slightly more complicated -- you probably need a 
>real
>writable file system which deals with NAND but you could use it 
>in
>read-only mode.

Thank you very much. I will try again with CRAMFS.

Nanda


