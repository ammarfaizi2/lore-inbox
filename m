Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261457AbULUJS2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261457AbULUJS2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 04:18:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261450AbULUJS1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 04:18:27 -0500
Received: from rproxy.gmail.com ([64.233.170.193]:4011 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261457AbULUJO0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 04:14:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=dYwPxPtUqtdBUfCM9t8cznetQa6e6qiaEC2sQjhyLd3R3PL26qf9u3oLbmaBF1dP41dLXORhhMKdg1JuNYflaCiLKeC9IQP1Z1N4bCt5LCPPtkEc34otUrn0Y2v3hnWP/z+X3vuaUoA9XHbNwFAzOzCpUSzAvC0f2e+Qj4Io4S0=
Message-ID: <72c6e3790412210114650e05d1@mail.gmail.com>
Date: Tue, 21 Dec 2004 14:44:23 +0530
From: linux lover <linux.lover2004@gmail.com>
Reply-To: linux lover <linux.lover2004@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: loading modules at kernel startup
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
                  How to load own kernel modules just after eth0
interface is brought up?
I want to load kernel module as soon as networking part of kenrel
starts. I dont want to loose any packets that travels on my linux
machine.
regards,
linux_lover
