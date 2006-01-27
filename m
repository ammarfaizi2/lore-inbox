Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932164AbWA0Rcg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932164AbWA0Rcg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 12:32:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932175AbWA0Rcf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 12:32:35 -0500
Received: from lila.akte.de ([213.239.211.75]:22462 "EHLO lila.akte.de")
	by vger.kernel.org with ESMTP id S932164AbWA0Rcf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 12:32:35 -0500
KRecCount: 1
KInfo: virscan ok
KInfo: !spam auth
Date: Fri, 27 Jan 2006 18:32:15 +0100
From: Andy Spiegl <kernelbug.Andy@spiegl.de>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: Benoit Boissinot <bboissin@gmail.com>, John Stoffel <john@stoffel.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.15 crashes X Server after running OpenGL programs
Message-ID: <20060127173215.GC19166@spiegl.de>
Mail-Followup-To: Andy Spiegl <kernelbug.Andy@spiegl.de>,
	Alistair John Strachan <s0348365@sms.ed.ac.uk>,
	Benoit Boissinot <bboissin@gmail.com>,
	John Stoffel <john@stoffel.org>, linux-kernel@vger.kernel.org
References: <20060124121542.GB13646@spiegl.de> <20060124142151.GA3538@spiegl.de> <40f323d00601240713x26c3a04cra46e1cd9639b12f2@mail.gmail.com> <200601241937.06679.s0348365@sms.ed.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601241937.06679.s0348365@sms.ed.ac.uk>
X-PGP-GPG-Keys: mail -s "send pgp" auto@spiegl.de
X-Accepted-File-Formats: ASCII OpenOffice .rtf .pdf - *NO* Microsoft files please.
X-why-you-shouldnt-use-MS-LookOut: http://www.jensbenecke.de/l-oe-en.php
X-warum-man-MS-Outlook-vermeiden-sollte: http://www.jensbenecke.de/l-oe-de.php
X-Message-Flag: LookOut! You are using an insecure mail reader which can be used to spread viruses.
X-how-to-quote: http://learn.to/quote/
X-how-to-ask-questions: http://www.catb.org/~esr/faqs/smart-questions.html
X-stupid-disclaimers: http://goldmark.org/jeff/stupid-disclaimers/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Radeon 9000 is supported in Xorg and as far as i know was already supported
> > in Xfree86. The open-source driver works fine for me (Radeon 9200SE).
> 
> Indeed. Mesa will provide direct render acceleration on these cards without 
> using the proprietary driver. Since the 9000 is really too old to run modern 
> games, I suspect it will be more than adequate.

Maybe I am doing something wrong but Mesa is awfully slow.
I don't need highend acceleration but I can't even play tuxracer.

Maybe I missed something???

gl-info says:
 GL_VENDOR = "Mesa project: www.mesa3d.org"
 GL_RENDERER = "Mesa GLX Indirect"
 GL_VERSION = "1.3 Mesa 4.0.4"
 GL_EXTENSIONS = "GL_ARB_imaging GL_ARB_multitexture GL_ARB_texture_border_clamp GL_ARB_texture_cube_map GL_ARB_texture_env_add GL_ARB_texture_env_combine GL_ARB_texture_env_dot3 GL_ARB_transpose_matrix GL_EXT_abgr GL_EXT_blend_color GL_EXT_blend_minmax GL_EXT_blend_subtract GL_EXT_texture_env_add GL_EXT_texture_env_combine GL_EXT_texture_env_dot3 GL_EXT_texture_lod_bias "

> I'd investigate the open source solution, because ATI's proprietary driver is 
> poor quality, even for your average binary vendor.
yep, just like nvidias drivers.  I had very bad experiences with them.

Thanks,
 Andy.

-- 
 Fotos: francisco.spiegl.de            o      _     _         _              
 Infos: peru.spiegl.de       __o      /\_   _ \\o  (_)\__/o  (_)         -o) 
 Andy, Heidi, Francisco    _`\<,_    _>(_) (_)/<_    \_| \   _|/' \/      /\\
 heidi.und.andy@spiegl.de (_)/ (_)  (_)        (_)   (_)    (_)'  _\o_   _\_v
 ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
 Use the Source, Luke!
