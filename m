Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261840AbTC0J2X>; Thu, 27 Mar 2003 04:28:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261841AbTC0J2X>; Thu, 27 Mar 2003 04:28:23 -0500
Received: from tartu.cyber.ee ([193.40.6.68]:33796 "EHLO tartu.cyber.ee")
	by vger.kernel.org with ESMTP id <S261840AbTC0J2W>;
	Thu, 27 Mar 2003 04:28:22 -0500
From: Meelis Roos <mroos@linux.ee>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.21-pre6
In-Reply-To: <Pine.LNX.4.53L.0303262107480.2544@freak.distro.conectiva>
User-Agent: tin/1.5.17-20030301 ("Bubbles") (UNIX) (Linux/2.4.18 (i586))
Message-Id: <E18yVqr-0004gQ-00@roos.tartu-labor>
Date: Thu, 27 Mar 2003 13:47:21 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

MT> Here goes -pre6.
MT> 
MT> We are approaching -rc stage. I plan to release -pre7 shortly which should
MT> fixup the remaining IDE problems (thanks Alan!) and -rc1 later on.

HDLC started generating warnings in some -pre and they are still there:

/oma/compile/linux-2.4/include/linux/modules/hdlc.ver:3: warning: `__ver_register_hdlc_device' redefined
/oma/compile/linux-2.4/include/linux/modules/hdlc_generic.ver:3: warning: this is the location of the previous definition
/oma/compile/linux-2.4/include/linux/modules/hdlc.ver:5: warning: `__ver_unregister_hdlc_device' redefined
/oma/compile/linux-2.4/include/linux/modules/hdlc_generic.ver:5: warning: this is the location of the previous definition

-- 
Meelis Roos (mroos@linux.ee)
