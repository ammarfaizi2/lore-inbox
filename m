Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135363AbRDWPan>; Mon, 23 Apr 2001 11:30:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135353AbRDWPaf>; Mon, 23 Apr 2001 11:30:35 -0400
Received: from mailhub2.shef.ac.uk ([143.167.2.154]:35506 "EHLO
	mailhub2.shef.ac.uk") by vger.kernel.org with ESMTP
	id <S135354AbRDWPa2>; Mon, 23 Apr 2001 11:30:28 -0400
Date: Mon, 23 Apr 2001 16:30:26 +0100 (BST)
From: Guennadi Liakhovetski <g.liakhovetski@ragingbull.com>
To: linux-kernel@vger.kernel.org
Subject: atomicps - updated patch
Message-ID: <Pine.LNX.4.21.0104231620380.29822-100000@erdos.shef.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all

I planned to use atomicps patch from
http://bkernel.sourceforge.net/
in a package, for which I ported it to 2.4.0 and also added a few ioctl()s
to enable some (simple) single-criterion process selection. So, I just
wanted to say, that this patch exists, is available for download from
http://cvs.sourceforge.net/cgi-bin/viewcvs.cgi/netcontrol/netcontrol-dev/src/atomicps/
It might not be very clean and well commented/documented at the moment,
but if there is a demand for it and if you have problems with it, please
drop me a line and I'll try to help. Also I tried to contact the author of
the original patch - Borislav Deianov, but didn't get any replies. And
thanks to Albert Cahalan for his help.

Thanks
Guennadi
___

Dr. Guennadi V. Liakhovetski
Department of Applied Mathematics
University of Sheffield, U.K.
email: G.Liakhovetski@sheffield.ac.uk


