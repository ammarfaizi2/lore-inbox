Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264252AbTFUOFE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 10:05:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264372AbTFUOFE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 10:05:04 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:51911
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S264252AbTFUOE7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 10:04:59 -0400
Subject: Re: ACPI (20030522) breaks 3c59x in 2.4/2.5
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Yaroslav Rastrigin <yarick@relex.ru>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200306152124.51449.yarick@relex.ru>
References: <200306152124.51449.yarick@relex.ru>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1056205002.25974.40.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 21 Jun 2003 15:16:48 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-06-15 at 18:24, Yaroslav Rastrigin wrote:
> Hi everybody.
> I've finally decided to try ACPI on my IBM ThinkPad T21 .
> Mostly, it works nice and fine (although I'm still wondering what S1 sleep 
> state _supposed_ to do, now it's acting weird), but one thing is a real 
> showstoppper for me - 

Should work in 2.4-ac trees

