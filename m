Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287450AbSAPU26>; Wed, 16 Jan 2002 15:28:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287464AbSAPU2i>; Wed, 16 Jan 2002 15:28:38 -0500
Received: from zeus.kernel.org ([204.152.189.113]:38805 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S287450AbSAPU22>;
	Wed, 16 Jan 2002 15:28:28 -0500
Subject: Re: floating point exception
From: Christian Thalinger <e9625286@student.tuwien.ac.at>
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        "Richard B. Johnson" <root@chaos.analogic.com>, davej@suse.de
In-Reply-To: <Pine.LNX.4.44.0201161632001.23365-100000@netfinity.realnet.co.sz>
In-Reply-To: <Pine.LNX.4.44.0201161632001.23365-100000@netfinity.realnet.co.sz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 16 Jan 2002 21:26:42 +0100
Message-Id: <1011212807.507.3.camel@sector17.home.at>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-01-16 at 15:32, Zwane Mwaikambo wrote:
> Can you also reproduce _without_ loading NVdriver, just to make everybody 
> happy.
> 
> Thanks,
> 	Zwane Mwaikambo
> 

Sure, same breakdown. Maybe it's really an dual athlon xp issue as dave
jones mentioned. But shouldn't this also occur when i trigger a floating
point exception myself? Is there a way to check which floating point
exception was raised by the seti client?

Regards.

