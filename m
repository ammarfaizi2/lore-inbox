Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751605AbWA1SDo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751605AbWA1SDo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 13:03:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751606AbWA1SDo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 13:03:44 -0500
Received: from uproxy.gmail.com ([66.249.92.202]:11597 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751604AbWA1SDo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 13:03:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Hy4buZvjuAh4l9dAQKXD+Ok0zXd1ob0md9qDMEldn7UB1XRju4JbPEWCqO0xTfDTJaHanpMAONIuM0mv8d59tlnbfUCoir2m64HvqiKIzmQ9QpOfzRZ0MvUpOiLdrA1svDdkaokOT2l76JYV6nfg2OysxXbqDMMZFkkow0dLLwU=
From: Marek =?iso-8859-2?q?Va=B9ut?= <marek.vasut@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iforce: fix -ENOMEM check
Date: Sat, 28 Jan 2006 19:03:27 +0100
User-Agent: KMail/1.7.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601281903.28176.marek.vasut@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have tried that patch, but nothing changed ...
That error is still there and no new device in /dev/input appears
