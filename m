Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964976AbWCTQSG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964976AbWCTQSG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 11:18:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964934AbWCTQSF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 11:18:05 -0500
Received: from wproxy.gmail.com ([64.233.184.192]:37432 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964976AbWCTQSA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 11:18:00 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NSFc1QzvRr0rizYuXsrnfNbsUkpdqtjq7Dg67Cu9oNteK7QPNTLyuEGLPbRfspmdhbXddDHx6s38JiMabCT59xSl/YrIN+Q//3Eeon5NCPA30sFLw7ES93UE68b3iwdPlyfwx6z+T2f5T2iWjppH7MqU8YDFedgAx1nsR4IoUI8=
Message-ID: <305c16960603200817u3c8e4023nf2621245fdb0ed65@mail.gmail.com>
Date: Mon, 20 Mar 2006 13:17:59 -0300
From: "Matheus Izvekov" <mizvekov@gmail.com>
To: "Jan Engelhardt" <jengelh@linux01.gwdg.de>
Subject: Re: Who uses the 'nodev' flag in /proc/filesystems ???
Cc: "Neil Brown" <neilb@suse.de>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0603201659250.22395@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <17436.60328.242450.249552@cse.unsw.edu.au>
	 <Pine.LNX.4.61.0603191024420.1409@yvahk01.tjqt.qr>
	 <17438.13214.307942.212773@cse.unsw.edu.au>
	 <Pine.LNX.4.61.0603201659250.22395@yvahk01.tjqt.qr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/20/06, Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:
>
> I wonder if there is a filesystem that is nodev, but has fsck.
>
>
> Jan Engelhardt
> --

If a filesystem is nodev, then what would you fsck? Am i missing something?
