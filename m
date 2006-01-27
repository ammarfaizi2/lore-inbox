Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751537AbWA0Swn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751537AbWA0Swn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 13:52:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751539AbWA0Swm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 13:52:42 -0500
Received: from zproxy.gmail.com ([64.233.162.199]:17570 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751536AbWA0Swm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 13:52:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=XGOqO/3fF14znN+OPVi4uYXfMIxcL2Q56HiNgyKfdwO4siWwMh5yf2Q4Lj/XgcFXvZvwR2blfltp4E/X5ON+BP0L36/GEzApyzM2ychse2WBlE8IPzQOa7NzSQAI9hD2sGVY8hsUXMMVDCLbN7jwP5ZpdEAh3YmFYYqQuK0W3HM=
Message-ID: <7f45d9390601271052j68255baq5f5ef14fa188d03d@mail.gmail.com>
Date: Fri, 27 Jan 2006 11:52:40 -0700
From: Shaun Jackman <sjackman@gmail.com>
Reply-To: Shaun Jackman <sjackman@gmail.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Advantech touch screen driver
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an Advantech TPC-1260T touch panel computer. The touch screen
is an RTKC manufactured by Liyitec. The electrical interface of the
touch screen is PS/2, but the protocol does not seem to be PS/2.
Liyitec provides a binary driver for XFree86 on i386-linux, named
tsps2 1.1.0, but I have not been able to find an open source driver.
I'm considering writing my own. Has anyone else started down this
path?

Please cc me in your reply. Cheers!
Shaun
