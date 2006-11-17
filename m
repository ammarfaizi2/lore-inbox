Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424268AbWKQNgl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424268AbWKQNgl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 08:36:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424330AbWKQNgl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 08:36:41 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:3153 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1424268AbWKQNgj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 08:36:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=qRnOi4y/+iGqKcB5unIWMoPHWwgtm4w1IrzTeh/+aiYiSaR8kw9sjINRSHhQdnRd8lAlANbiTelXLA5cIYHZ+81Fcj5+9y+fhwgl7CPIGvdiHEO5fj9MjRCiQRMlC5UDY9+V/xqKmhDQ8qH0psFwtzyLA5Ra8bC1NqvrRs9z/yo=
Message-ID: <3420082f0611170536h6f566332u92e545363aa6a9f1@mail.gmail.com>
Date: Fri, 17 Nov 2006 17:36:38 +0400
From: "Irfan Habib" <irfan.habib@gmail.com>
To: "Linux kernel" <linux-kernel@vger.kernel.org>
Subject: finding the network usage of a process
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Is there any method either kernel or user level which tells me which
process is generating how much traffic from a machine. For example if
some process is flooding the network, then I would like to know which
process (PID ideally), is generating the most traffic.

I dont require it to do this remotely, it should be run on the same
machine as that originates the traffic, additionally last time when I
asked a similar question people answered with stap modules, but I'm
using kernel 2.4.26 and I can't get SystemTap to compile on the system
with glibc-2.3.6.


Any help will be highly appreciated

Regards
Irfan
