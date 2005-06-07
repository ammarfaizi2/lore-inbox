Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261753AbVFGFxp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261753AbVFGFxp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 01:53:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261795AbVFGFxp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 01:53:45 -0400
Received: from wproxy.gmail.com ([64.233.184.202]:18310 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261753AbVFGFxe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 01:53:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LCW0cHF4NRK3V+PXk9aZBOOqHXmWkK/HHXCjV87mxglRK4yopno8jyUNaL5r0vorTvHFeGWKLkwOpgHc/3PuPtIncRP2F3sd+tEWTa5zHzkIiNziEZimL8dUvfPYy3RFpuAQ0joYzThipgbTEFy24x0IMhXia/Fs7mfZsu460Iw=
Message-ID: <19f134cc05060622527268189b@mail.gmail.com>
Date: Tue, 7 Jun 2005 11:22:59 +0530
From: Pradeep Anbumani <pradeepdreams@gmail.com>
Reply-To: Pradeep Anbumani <pradeepdreams@gmail.com>
To: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Fwd: seq no of the last data pkt received in response to fast retransmit done by sender!!!!
In-Reply-To: <19f134cc050603012766375004@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <19f134cc050603012766375004@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

---------- Forwarded message ----------
From: Pradeep Anbumani <pradeepdreams@gmail.com>
Date: Jun 3, 2005 1:57 PM
Subject: seq no of the last data pkt received in response to fast retransmit!!!!
To: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org


Hi,
 Can anyone Tell me the variable in the linux TCP implementation
which stores the sequence number of the last data packet received in
response to fast retransmit.

regards,
Pradeep.A
