Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262893AbVD2TMu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262893AbVD2TMu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 15:12:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262889AbVD2TKQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 15:10:16 -0400
Received: from wproxy.gmail.com ([64.233.184.202]:36767 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262896AbVD2TJH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 15:09:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:user-agent:x-accept-language:mime-version:to:subject:content-type:content-transfer-encoding;
        b=X6b9Em9hQPWPG2lTxLCCQ2WUQPRSvCH1JPYVcEcm2Cw3o2wzhN8AidSFX8T0dbR3OEDyBaj7f5eVVX0T/Kjje8JzRmr5GREsD0HhtIBRAkqxrig+Mad0vO7cY6fWLsksL82wwN01dTOFVOgd0Hv2xV8FCcqKSY4cCnw7J6wv1RI=
Message-ID: <42728649.5080501@gmail.com>
Date: Fri, 29 Apr 2005 21:08:57 +0200
From: Eric BEGOT <eric.begot@gmail.com>
Reply-To: eric.begot@gmail.com
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Inotify app
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

here is a little program which uses the inotify's functionnality. This 
soft lists a given directory in live. The informations are updated when 
an event occur. If no event occur, the process does nothing and sleeps !
The soft needs the libncurses (and inotify patch of course).
rml advised me to post this to the lkml so the others will be able to 
see how nice the inotify stuff is :)
You can download the soft here :

http://membres.lycos.fr/openunixes/inotify_app.tar.bz2

ciao
