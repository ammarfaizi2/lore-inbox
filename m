Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262583AbVG2OY5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262583AbVG2OY5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 10:24:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262600AbVG2OY5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 10:24:57 -0400
Received: from wproxy.gmail.com ([64.233.184.204]:39255 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262583AbVG2OY5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 10:24:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=k/TcATekqkepF7/XOKMpS2xgjN0CK4RCSq+C0oZ6jg35357cEqiLIByiapK76vir+JZq+sRyeB1g3sI9CGTHUWSSqkOFco6cSL6KuTa8uwJwU8l6b4hIQXyr8DN3JjjDM9utvPpzwwpXEXldGelvb5iN0qnstUoegYGK6FI1WGM=
Message-ID: <a5a7ef330507290724339135d2@mail.gmail.com>
Date: Fri, 29 Jul 2005 11:24:56 -0300
From: Vitor Curado <curado.vitor@gmail.com>
Reply-To: Vitor Curado <curado.vitor@gmail.com>
To: Wes Felter <wesley@felter.org>, Stephen Pollei <stephen.pollei@gmail.com>
Subject: Re: QoS scheduler
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <42E94F24.6030002@felter.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <a5a7ef3305072804283f196f79@mail.gmail.com>
	 <42E94F24.6030002@felter.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You assumed right, Stephen: I'm interested in QoS process scheduling,
sorry for not specifying it...

I'm taking a deeper look at the qlinux, ckrm and the plugsched
schedulers, if you have any more links, please send them to me...

Thanks!


On 7/28/05, Wes Felter <wesley@felter.org> wrote:
> Vitor Curado wrote:
> > I'm working on a research about QoS schedulers for Linux clusters.
> > Moreover, the ideal would be that the scheduler is implemented
> > altering the native kernel scheduler. I'm kind of having trouble to
> > find such schedulers, can anybody help me out?
> 
> http://lass.cs.umass.edu/software/qlinux/
> http://ckrm.sourceforge.net/
> 
>
