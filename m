Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265229AbUAJR1p (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 12:27:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265230AbUAJR1o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 12:27:44 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:17378 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265229AbUAJR1n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 12:27:43 -0500
Message-ID: <400035F5.3040300@pobox.com>
Date: Sat, 10 Jan 2004 12:27:17 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Piotr Kaczuba <pepe@attika.ath.cx>
CC: linux-kernel@vger.kernel.org
Subject: Re: tulip driver: errors instead TX packets?
References: <20040110144831.GA16080@orbiter.attika.ath.cx>
In-Reply-To: <20040110144831.GA16080@orbiter.attika.ath.cx>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Piotr Kaczuba wrote:
> I've got a ADMtek Centaur (3cSOHO100B-TX) running with the tulip driver  
> on 2.6.1. I wonder if anyone has noticed that ifconfig shows the  
> packets sent in the errors field instead of the TX packets field. At  
> least, this is what I assume because it shows 0 TX packets and 11756  
> errors.


This is an old error, but since packets show up, nobody bothers with the 
incorrect statistics...

	Jeff



