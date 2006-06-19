Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932444AbWFSNbI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932444AbWFSNbI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 09:31:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932448AbWFSNbI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 09:31:08 -0400
Received: from wr-out-0304.google.com ([64.233.184.213]:15737 "EHLO
	wr-out-0304.google.com") by vger.kernel.org with ESMTP
	id S932444AbWFSNbG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 09:31:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:message-id:user-agent:x-http-useragent:x-http-via:mime-version:content-type;
        b=iWcxdvFjEAeEo8Era2fBBsxwLWu7WX6G51955NU6ML0AhYxtUFkK7N2G1tjROKPsbyyCbrU22wDPqsqPzAmi0GOfnd/UIE+vuafiih2HRGPwM5g2eZWpVDwyUk/I7cgApYK+M6ZXYP1jRITxtVonxlk7aQ/Ha4l8wRhU4wfcYuo=
From: "~ ninad" <ninad.gfx@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: irq
Date: Mon, 19 Jun 2006 06:31:05 -0700
Message-ID: <1150723865.976316.296170@f6g2000cwb.googlegroups.com>
User-Agent: G2/0.2
X-HTTP-UserAgent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.12) Gecko/20050915 Firefox/1.0.7,gzip(gfe),gzip(gfe)
X-HTTP-Via: 1.1 pratapgad.mettatechnology.com:3128 (squid/2.5.STABLE6)
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In linux device driver, is it possible to register an ISR for multiple
irq lines?

