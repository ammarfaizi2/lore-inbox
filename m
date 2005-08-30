Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751446AbVH3QDO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751446AbVH3QDO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 12:03:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751450AbVH3QDO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 12:03:14 -0400
Received: from wproxy.gmail.com ([64.233.184.204]:10297 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751446AbVH3QDN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 12:03:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=fb4mZgfGGiX5XlFA2UjQw+FWWGb81izyeVQDux9hCiVX23i6KZGt+/NJGdC8c1Pl3ZD8LRMpfV9GVcxPNSh/c/97zZca8hKaBom2ZPKwW3Ivz78rmRaGiCnjb2xRoSL2zXEzmOJjn5fl8DqK1XP7jaYjB6WIDN+LjUw3FkCQYPo=
Message-ID: <9e47339105083009037c24f6de@mail.gmail.com>
Date: Tue, 30 Aug 2005 12:03:09 -0400
From: Jon Smirl <jonsmirl@gmail.com>
To: lkml <linux-kernel@vger.kernel.org>,
       Xserver development <xorg@freedesktop.org>
Subject: State of Linux graphics
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've written an article that surveys the current State of Linux
graphics and proposes a possible path forward. This is a long article
containing a lot of detailed technical information as a guide to
future developers. Skip over the detailed parts if they aren't
relevant to your area of work.

http://www.freedesktop.org/~jonsmirl/graphics.html

Topics include the current X server, framebuffer, Xgl, graphics
drivers, multiuser support, using the GPU, and a new server design.
Hopefully it will help you fill in the pieces and build an overall
picture of the graphics landscape.

The article has been reviewed but if it still contains technical
errors please let me know. Opinions on the content are also
appreciated.

-- 
Jon Smirl
jonsmirl@gmail.com
