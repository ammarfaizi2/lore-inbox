Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751737AbWJMQZO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751737AbWJMQZO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 12:25:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751750AbWJMQZN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 12:25:13 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:50120 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751737AbWJMQZM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 12:25:12 -0400
Subject: Re: [PATCH] HP mobile data protection system driver
From: Arjan van de Ven <arjan@infradead.org>
To: Burman Yan <yan_952@hotmail.com>
Cc: davej@redhat.com, jesper.juhl@gmail.com, linux-kernel@vger.kernel.org,
       pazke@donpac.ru
In-Reply-To: <BAY20-F21743EEAB4B44BD437AE68D80A0@phx.gbl>
References: <BAY20-F21743EEAB4B44BD437AE68D80A0@phx.gbl>
Content-Type: text/plain
Organization: Intel International BV
Date: Fri, 13 Oct 2006 18:25:02 +0200
Message-Id: <1160756702.14815.1.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> That would probably mean that there is a need for single interface. 

yes please

> Making 
> all accelerometers
> export to /sys/devices/platform/hdaps sounds wrong to me. It should be a 
> neutral place then.

well.... breaking stuff for no reason other than "but it sounds like HIS
name" is I thing bad. Yes the name is unfortunate, but if you can use
the interface... why not? Just because the name isn't perfect everyone
should change over, including keeping compatibility mess etc etc?
That needs a stronger reason than "it sounds like his name" to me...

Now if the interface itself isn't good enough, that's a different matter
of course; but from what I read so far that's not really the case.

Greetings,
   Arjan van de Ven

