Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266100AbRF2Oup>; Fri, 29 Jun 2001 10:50:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266101AbRF2Oue>; Fri, 29 Jun 2001 10:50:34 -0400
Received: from mail.muc.eurocyber.net ([195.143.108.5]:8695 "EHLO
	mail.muc.eurocyber.net") by vger.kernel.org with ESMTP
	id <S266100AbRF2Oua>; Fri, 29 Jun 2001 10:50:30 -0400
Message-ID: <3B3C95AF.9D125337@TeraPort.de>
Date: Fri, 29 Jun 2001 16:50:23 +0200
From: Martin Knoblauch <Martin.Knoblauch@TeraPort.de>
Organization: TeraPort GmbH
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-ac21 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: VM behaviour under 2.4.5-ac21
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

 just something positive for the weekend. With 2.4.5-ac21, the behaviour
on my laptop (128MB plus twice the sapw) seems a bit more sane. When I
start new large applications now, the "used" portion of VM actually
pushes against the cache instead of forcing stuff into swap. It is still
using swap, but the effects on interactivity are much lighter.

 So, if this is a preview of 2.4.6 bahaviour, there may be a light at
the end of the tunnel.

Have a good weekend
Martin
-- 
------------------------------------------------------------------
Martin Knoblauch         |    email:  Martin.Knoblauch@TeraPort.de
TeraPort GmbH            |    Phone:  +49-89-510857-309
C+ITS                    |    Fax:    +49-89-510857-111
http://www.teraport.de   |    Mobile: +49-170-4904759
