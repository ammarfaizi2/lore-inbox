Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281848AbRKWBAa>; Thu, 22 Nov 2001 20:00:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281847AbRKWBAV>; Thu, 22 Nov 2001 20:00:21 -0500
Received: from mail.delfi.lt ([213.197.128.86]:14598 "HELO
	mx-outgoing.delfi.lt") by vger.kernel.org with SMTP
	id <S281848AbRKWBAE> convert rfc822-to-8bit; Thu, 22 Nov 2001 20:00:04 -0500
Date: Fri, 23 Nov 2001 02:58:53 +0200 (EET)
From: Nerijus Baliunas <nerijus@users.sourceforge.net>
Subject: Re: [PATCH] Documentation/Changes
To: "=?ISO-8859-1?Q?Fr=E9d=E9ric=20L.=20W.=20Meunier?=" 
	<0@pervalidus.net>,
        Linux Kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: INLINE
In-Reply-To: <20011121022049.GR11449@pervalidus>
In-Reply-To: <20011121022049.GR11449@pervalidus>
X-Mailer: Mahogany, 0.64.1 'Sparc', compiled for Linux 2.4.14 i686
Message-Id: <20011123010003.693398F9AE@mail.delfi.lt>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Nov 2001 00:20:49 -0200 Frédéric L. W. Meunier <0@pervalidus.net> wrote:

FLWM> Hi. I updated several parts of the Documentation/Changes file
FLWM> (mostly URLs), reformated it to wrap at 72 and also removed all
FLWM> versions from the URLs, since that usually makes the user
FLWM> upgrade to a version which isn't the most recent (and
FLWM> compatible). An exception. GCC includes the full path to
FLWM> 2.95.3, because 3.0.x isn't the recommended compiler.

Why did you rename Gnu C to GNU Compiler Collection? Only C is used
in kernel compilation, no C++ or fortran. People might think that
whole "collection" is needed.

Regards,
Nerijus

