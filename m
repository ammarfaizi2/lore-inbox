Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030408AbWHOR7j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030408AbWHOR7j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 13:59:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030417AbWHOR7j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 13:59:39 -0400
Received: from wr-out-0506.google.com ([64.233.184.231]:34425 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030408AbWHOR7j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 13:59:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=qaF+8kAEA6BAsZs9mQ1bCMr55qZiZtWmMvkWveLqepqM8fniyDatC7NVA8Khj7F7S1dKRxONgauZ2U6txEbTlgkXdlPLe7EaMsCtXoQGvalGMXW8S9jf5EiIYUDTUfOM1nbfiIOLlZkkhH+NtcTWKY2dA5bCG+cDkIOxUkPS4SM=
Message-ID: <3420082f0608151059s40373a0bg4a1af3618c2b1a05@mail.gmail.com>
Date: Tue, 15 Aug 2006 22:59:37 +0500
From: "Irfan Habib" <irfan.habib@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Maximum number of processes in Linux
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

What is the maximum number of process which can run simultaneously in
linux? I need to create an application which requires 40,000 threads.
I was testing with far fewer numbers than that, I was getting
exceptions in pthread_create

Regards
Irfan
