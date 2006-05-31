Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965070AbWEaVHj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965070AbWEaVHj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 17:07:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965068AbWEaVHi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 17:07:38 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:1652 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S965070AbWEaVHh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 17:07:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=liZC7fxRIBnUuE1FrSZKMPoxeqeDjoDh8x1Ss2vXlUwQ3tabH5XBWdIwHNMbs4c155JeyWJjFU2r3uFiHc//Tk75eEfPiqBG6a3WSs8Lo2Aa11QrItJyYchVM+JJYCQGySRLZI8PKgHij60bTGIoI26lLnJo69DltS2o9N9GHHA=
Date: Wed, 31 May 2006 23:06:56 +0200
From: Diego Calleja <diegocg@gmail.com>
To: Valdis.Kletnieks@vt.edu
Cc: lista1@comhem.se, wfg@mail.ustc.edu.cn, linux-kernel@vger.kernel.org
Subject: Re: Adaptive Readahead V14 - statistics question...
Message-Id: <20060531230656.f10b37ad.diegocg@gmail.com>
In-Reply-To: <200605301649.k4UGnooZ004266@turing-police.cc.vt.edu>
References: <20060530053631.57899084.lista1@comhem.se>
	<200605301649.k4UGnooZ004266@turing-police.cc.vt.edu>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Tue, 30 May 2006 12:49:50 -0400,
Valdis.Kletnieks@vt.edu escribió:


> The desktop "feel" is certainly at least as good, but it's a lot harder
> to quantify that - yesterday I was doing some heavy-duty cleaning in my

My desktop seems to boot a bit faster with adaptive readahead. I setup
a environment running kdm with automatic login plus a kde session which runs
a konqueror window and a openoffice writer windows. The time it takes for
the system to show the OO window went from 1:19 to 1:16 (I did a couple of
test of each kernel). Not a very scientific measurement, bootchart probably
could do it better
