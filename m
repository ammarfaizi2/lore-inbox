Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261702AbVAITM5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261702AbVAITM5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 14:12:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261706AbVAITM5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 14:12:57 -0500
Received: from rproxy.gmail.com ([64.233.170.207]:17655 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261702AbVAITMz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 14:12:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=hP1jmVqL1blslmW9PulPFtErGNukWjQzGyj/YsMIs8wdpr8FU70Av4ZjNQ6qZSCBXr3OpJRcqX2MNkL/9GQidduEPaiPdZJzaLpSj3YLsW4+pgL3xcz9I+v7KIYY+DVm84dp+vxPp4EGT5r1TyAQjsnmffY6K4GHCrVGTNcoi+Q=
Message-ID: <884a349a0501091112300009ac@mail.gmail.com>
Date: Sun, 9 Jan 2005 20:12:54 +0100
From: Roseline Bonchamp <roseline.bonchamp@gmail.com>
Reply-To: Roseline Bonchamp <roseline.bonchamp@gmail.com>
To: indrek.kruusa@tuleriit.ee
Subject: Re: remove Attach another file remove Attach another file remove Attach another file USB mass storage not always detecting my 1GB PQI intelligent stick
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <41E15F09.70502@tuleriit.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <884a349a050109082516b0740e@mail.gmail.com>
	 <41E15F09.70502@tuleriit.ee>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Do you have several different USB devices connected in the same time? It
> is possible that devices with different USB speed (high/full) cannot
> work together. I am not the kernel developer but this is just my
> experience with latest Linux distributions. The situation can be
> different with current USB developments.

I tried to remove every other USB device. What is really strange is
that it works when I've just booted Linux, but if I unplug/replug the
device it seems to be "detected", but is not listed in
/proc/bus/usb/devices
