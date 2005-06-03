Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261177AbVFCI1T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261177AbVFCI1T (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 04:27:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261181AbVFCI1T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 04:27:19 -0400
Received: from wproxy.gmail.com ([64.233.184.193]:36966 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261177AbVFCI1Q convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 04:27:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=sVzEHueBZg5q84wHZWbL+MJuLOnZu3NqIGgTwqwxKHAHNIcRWPArFrJ7GSwnPq0J/NVDdzgZbNs9yt1JZZEAs0tH+yKl1k7/LOawb4n30qLsuiA/gkW4A8WRiMdoLCpj4QfXgg1QZYHKuae7/ntI+rPlJusnUHcA9asOO1L+JAs=
Message-ID: <19f134cc050603012766375004@mail.gmail.com>
Date: Fri, 3 Jun 2005 13:57:16 +0530
From: Pradeep Anbumani <pradeepdreams@gmail.com>
Reply-To: Pradeep Anbumani <pradeepdreams@gmail.com>
To: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: seq no of the last data pkt received in response to fast retransmit!!!!
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  Can anyone Tell me the variable in the linux TCP implementation
which stores the sequence number of the last data packet received in
response to fast retransmit.

regards,
Pradeep.A
