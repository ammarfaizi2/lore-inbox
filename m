Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265470AbTCELkV>; Wed, 5 Mar 2003 06:40:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265523AbTCELkU>; Wed, 5 Mar 2003 06:40:20 -0500
Received: from visp12-175.visp.co.nz ([210.54.175.12]:65038 "EHLO
	mdew.dyndns.org") by vger.kernel.org with ESMTP id <S265470AbTCELkU>;
	Wed, 5 Mar 2003 06:40:20 -0500
Subject: Re: reducing stack usage in v4l?
From: mdew <mdew@mdew.dyndns.org>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <87u1eigomv.fsf@bytesex.org>
References: <32833.4.64.238.61.1046841945.squirrel@www.osdl.org>
	 <87u1eigomv.fsf@bytesex.org>
Content-Type: text/plain
Organization: 
Message-Id: <1046865047.2310.33.camel@nirvana.flat>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 06 Mar 2003 00:50:48 +1300
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On the topic of v4l, Ive had complete lockups on recent 2.5.x kernels
when loading a v4l application Zapping. I havent tried anyother v4l
applications just yet, have you seen this in action? should i compile
debuging support to show it? /var/log/messages currently doesnt show it.

Running Debian Sid/Gcc 3.2.3 20030228


-- 
mdew <mdew@mdew.dyndns.org>

