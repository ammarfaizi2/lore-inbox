Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965075AbVINHzp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965075AbVINHzp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 03:55:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965076AbVINHzp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 03:55:45 -0400
Received: from wproxy.gmail.com ([64.233.184.203]:62619 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965075AbVINHzo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 03:55:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=pZHgIXiBZLgs1d2dREP6G48vOaHg2Mg6cTr4Kb7MSK/ftmnxr5sWR9+9AZIiU+w56jCgPcgywdkaEehXPLFzbK2+EFZ/Yr/mZSYHuTr2u87Z2LOxjUMuowE9wNNIm533vBLMVUg/1EjOB1Dv6Zadm8Wq9iyC3O7mAfPoBkxcGx8=
Message-ID: <bae323a50509140055589e843e@mail.gmail.com>
Date: Wed, 14 Sep 2005 09:55:41 +0200
From: Carlos Ojea Castro <nuudoo.fb@gmail.com>
Reply-To: nuudoo.fb@gmail.com
To: linux-kernel@vger.kernel.org
Subject: compulab's SB-i686 VIP demo application I2C problem
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello! I am using a compulab's SB-i686 and I am trying the VIP (Video
Input Port) support and demo application.
When I load the saa7113 driver, I think I must be able to see with an
oscilloscope the i2c bus working at pins GP12 and GP13 trying to
connect to the saa7113h, but there is no signal at these pins.
Does it mean that the demo application is made for compulab's
ATX-i686? I am considering the change to the compulab's ATX-i686.
How can I make the demo application's i2c working at pins SGP12 and SGP13?

Please, reply me to nuudoo.fb@gmail.com. I am not currently subscribed
to this list becouse I am not sure if this is the correct list to post
to. Please, tell me if I should post to another list.

Regards,
Carlos
