Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275611AbRIZVS2>; Wed, 26 Sep 2001 17:18:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275609AbRIZVSR>; Wed, 26 Sep 2001 17:18:17 -0400
Received: from shell.cyberus.ca ([209.195.95.7]:63403 "EHLO shell.cyberus.ca")
	by vger.kernel.org with ESMTP id <S275608AbRIZVSL>;
	Wed, 26 Sep 2001 17:18:11 -0400
Date: Wed, 26 Sep 2001 17:15:40 -0400 (EDT)
From: jamal <hadi@cyberus.ca>
To: Ingo Molnar <mingo@elte.hu>
cc: <linux-kernel@vger.kernel.org>, <linux-net@vger.kernel.org>,
        <netdev@oss.sgi.com>
Subject: Re: [patch] netconsole - log kernel messages over the network.
 2.4.10.
In-Reply-To: <Pine.LNX.4.21.0109261635190.957-100000@freak.distro.conectiva>
Message-ID: <Pine.GSO.4.30.0109261713500.6825-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Is there any reason you are not using dev_queue_xmit()?
(side benefits, you could hack this into using scatter gather schemes etc)

cheers,
jamal

