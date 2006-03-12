Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932242AbWCLMq0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932242AbWCLMq0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 07:46:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932159AbWCLMqZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 07:46:25 -0500
Received: from mxout1.netvision.net.il ([194.90.9.20]:45622 "EHLO
	mxout1.netvision.net.il") by vger.kernel.org with ESMTP
	id S932104AbWCLMqZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 07:46:25 -0500
Date: Sun, 12 Mar 2006 14:46:55 +0300
From: Maxim Kozover <maximkoz@netvision.net.il>
Subject: Re: Re: Re[8]: problems with scsi_transport_fc and qla2xxx
In-reply-to: <1142155684.2882.15.camel@laptopd505.fenrus.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       Andrew Vasquez <andrew.vasquez@qlogic.com>
Reply-to: Maxim Kozover <maximkoz@netvision.net.il>
Message-id: <518308279.20060312144655@netvision.net.il>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
X-Priority: 3 (Normal)
References: <1119462161.20060306230951@netvision.net.il>
 <20060306212835.GO6278@andrew-vasquezs-powerbook-g4-15.local>
 <1229893529.20060307000953@netvision.net.il>
 <20060306232831.GS6278@andrew-vasquezs-powerbook-g4-15.local>
 <1219491790.20060307124035@netvision.net.il>
 <20060307172227.GE6275@andrew-vasquezs-powerbook-g4-15.local>
 <1343850424.20060307231141@netvision.net.il>
 <20060308080050.GF9956@andrew-vasquezs-powerbook-g4-15.local>
 <20060308154341.GA1779@andrew-vasquezs-powerbook-g4-15.local>
 <1502511597.20060308213247@netvision.net.il>
 <20060310231344.GB641@andrew-vasquezs-powerbook-g4-15.local>
 <1699632492.20060312001014@netvision.net.il>
 <1142155684.2882.15.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, Arjan, thanks!

Maxim.

AvdV> looks like your fiber fabric decided to renegotiate, and halfway it went
AvdV> for a coffee and donuts break to not upset the union rules :)

AvdV> I've seen LOOP negotiations take 10+ seconds before, and that is on a
AvdV> really simple setup.... so nothing super special 


