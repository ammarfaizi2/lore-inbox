Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285655AbRLGXUo>; Fri, 7 Dec 2001 18:20:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285658AbRLGXUe>; Fri, 7 Dec 2001 18:20:34 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:60166 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S285655AbRLGXUY>;
	Fri, 7 Dec 2001 18:20:24 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-ia64@linuxia64.org
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Linux 2.4.17-pre6 drm-4.0
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 08 Dec 2001 10:20:10 +1100
Message-ID: <4494.1007767210@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Dec 2001 19:38:23 -0200 (BRST), 
Marcelo Tosatti <marcelo@conectiva.com.br> wrote:
>pre6:
>- direct render for some SiS cards		(Torsten Duwe/Alan Cox)

IA64 is still using the drm-4.0 code, as are the (possibly obsolete)
-ac kernels.  The drm 4.0 makefiles are a pain in the neck and I want
to get rid of them asap.  The SiS direct render is only for drm 4.1 so
now is a good time to question if 4.0 is still required.

How long do people plan to keep drm 4.0 code in their versions of the
kernel?

