Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262373AbVCJIKW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262373AbVCJIKW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 03:10:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262391AbVCJIKW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 03:10:22 -0500
Received: from rproxy.gmail.com ([64.233.170.205]:16198 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262373AbVCJIKS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 03:10:18 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=dAxqhY6xtEq8RezzmkZtyIpdIv0cun5fU0o1h7CUWcP7FFCIO+LVrG4j9zAVbnA/AR8Rcp+9wxnKuB4mhp7eK8tXCK5s+U7XouGN6BUe1oh8RL5HikMBGSCzQJYyOy4siUDtpxDvX6I3v5QKkq4kb8MhK1XTMugd3vxGApcthlw=
Message-ID: <c4b38ec4050310001061c62b9d@mail.gmail.com>
Date: Thu, 10 Mar 2005 16:10:18 +0800
From: Jason Luo <abcd.bpmf@gmail.com>
Reply-To: Jason Luo <abcd.bpmf@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Can I get 200M contiguous physical memory?
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Now, I am writing a driver, which need 200M contiguous physical
memory? can do? how to do it?

thanks!
Jason
