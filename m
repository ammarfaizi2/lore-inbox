Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261401AbTCTMI3>; Thu, 20 Mar 2003 07:08:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261412AbTCTMI3>; Thu, 20 Mar 2003 07:08:29 -0500
Received: from mail.idilis.net ([217.156.85.2]:16237 "EHLO mail.idilis.net")
	by vger.kernel.org with ESMTP id <S261401AbTCTMI2>;
	Thu, 20 Mar 2003 07:08:28 -0500
Message-ID: <3E79B200.6030305@easynet.ro>
Date: Thu, 20 Mar 2003 14:20:16 +0200
From: Alex Damian <ddalex_krn@easynet.ro>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ro-RO; rv:1.0.1) Gecko/20020830
X-Accept-Language: ro, en, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: New PixelView driver
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I wrote a PixelView (Cirrus Logic GD-5465) tuner&grabber device driver. 
(V4L interface)

 I'm not sure to which kernel should I patch against (I developed using 
vanilla 2.4.20).

Should I try diff's against current 2.4.x , or try to make it to the 
2.5.current and drop
support for 2.4.x ? or maybe both.

Respect,
Alex Damian

