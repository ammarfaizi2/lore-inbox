Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312495AbSDFQKp>; Sat, 6 Apr 2002 11:10:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311884AbSDFQKo>; Sat, 6 Apr 2002 11:10:44 -0500
Received: from relay1.pair.com ([209.68.1.20]:23053 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id <S312588AbSDFQKU>;
	Sat, 6 Apr 2002 11:10:20 -0500
X-pair-Authenticated: 24.126.75.99
Message-ID: <3CAF20EF.B8AC1459@kegel.com>
Date: Sat, 06 Apr 2002 08:23:11 -0800
From: Dan Kegel <dank@kegel.com>
Reply-To: dank@kegel.com
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Fedyk <mfedyk@matchmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cleanup KERNEL_VERSION definition and linux/version.h
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk <mfedyk@matchmail.com> wrote:

>Do you know where I could find some good documentation on Makefiles?
>Especially on dependencies and etc?

Once you get past the basics of make, here are some threads
about best practice with large projects:

http://www.pcug.org.au/~millerp/rmch/recu-make-cons-harm.html
http://gcc.gnu.org/ml/gcc/2000-11/msg00901.html
http://www.mail-archive.com/automake-admin@gnu.org/msg00249.html

- Dan
