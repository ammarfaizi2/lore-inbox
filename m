Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261750AbSJZBAN>; Fri, 25 Oct 2002 21:00:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261755AbSJZBAN>; Fri, 25 Oct 2002 21:00:13 -0400
Received: from pimout4-ext.prodigy.net ([207.115.63.103]:10901 "EHLO
	pimout4-ext.prodigy.net") by vger.kernel.org with ESMTP
	id <S261750AbSJZBAM> convert rfc822-to-8bit; Fri, 25 Oct 2002 21:00:12 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Rob Landley <landley@trommello.org>
Reply-To: landley@trommello.org
To: linux-kernel@vger.kernel.org, viro@math.psu.edu,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: What's the status of 32 bit dev_t?
Date: Fri, 25 Oct 2002 15:06:24 -0500
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200210251506.24743.landley@trommello.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan said that 32 bit dev_t was one of the most important remaining new 
features, but I haven't seen a patch submitted for inclusion.  Closest 
anybody's been able to dredge up is an old plan from Al Viro, which lwn.net 
linked to here:

http://lwn.net/Articles/11583/

Is this a 2.5.45 thing?  Could it possibly go in after the feature freeze 
(I.E. without any API changes)?  Is it now deferred until the next 
development cycle?  Is there, in point of fact, a patch against 2.5.44?

Rob

-- 
http://penguicon.sf.net - Terry Pratchett, Eric Raymond, Pete Abrams, Illiad, 
CmdrTaco, liquid nitrogen ice cream, and caffienated jello.  Well why not?
