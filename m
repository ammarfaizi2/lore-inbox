Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932192AbWJJQMn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932192AbWJJQMn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 12:12:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932197AbWJJQMn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 12:12:43 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:56569 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932192AbWJJQMm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 12:12:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=gPz7gAZ/5c8jxKP6yLAakEzzxLn3NxdNNUpTtjNk60DMwGCBKie/UAok/QGnJev40l59/3bZcYG2OyyYFh0CMLkyvzqSRcdnNthxhk5gsAAeOULDEQI9vUVZfIUX75EhXM8k+7IB76JFPZk21G7ofetnHBaUIl0cjjB1wQ0zljQ=
Message-ID: <a44ae5cd0610100912j2ddf7b17lcfea645415f352f3@mail.gmail.com>
Date: Tue, 10 Oct 2006 09:12:41 -0700
From: "Miles Lane" <miles.lane@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: 2.6.19-rc1-mm1 -- WARNING: "toshoboe_invalid_dev" [drivers/net/irda/donauboe.ko] undefined!
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This stops the "make modules_install" process.
