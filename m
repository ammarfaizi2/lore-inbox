Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261198AbVG1L2Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261198AbVG1L2Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 07:28:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261225AbVG1L2P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 07:28:15 -0400
Received: from wproxy.gmail.com ([64.233.184.201]:4887 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261198AbVG1L2O convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 07:28:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=OvsqdkoMB9H6x65Blrwbz8u3R5qbfqsXqJueLGnzyCZuYdvNMG84GzbUTvNW88RCYSbv5xJU2ehDlJBZURdCD9dgG/+9FDbxUZTzKjD0WOAvLlQWCmv4+X6mhVTH5vww9XJol9Kgm4ph59nKD5jzSQILHc/gDIlZlaU3o5NF2E8=
Message-ID: <a5a7ef3305072804283f196f79@mail.gmail.com>
Date: Thu, 28 Jul 2005 08:28:14 -0300
From: Vitor Curado <curado.vitor@gmail.com>
Reply-To: Vitor Curado <curado.vitor@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: QoS scheduler
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm working on a research about QoS schedulers for Linux clusters.
Moreover, the ideal would be that the scheduler is implemented
altering the native kernel scheduler. I'm kind of having trouble to
find such schedulers, can anybody help me out?

Thanks,

Vitor
