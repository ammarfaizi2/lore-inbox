Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261531AbUKIMIs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261531AbUKIMIs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 07:08:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261528AbUKIMIs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 07:08:48 -0500
Received: from rproxy.gmail.com ([64.233.170.192]:711 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261521AbUKIMIo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 07:08:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=J+Bq579HUn+pv+0ZfEXOURRaol2YLkeH9Ypp3uzEUwZyIJUL9SL3YNEEAvA2qmNyipHWjBPnU9/O3TFSVVQmgLM/xo81e/qrYtfL2UvCPEygNWdWUam8CzvzZzK7VS62X8YSY7sY2PIVoHLYr7ovIAsPqU3L1b4Y9Qf26w3Uqv0=
Message-ID: <a9951d2a04110904087d3a93e0@mail.gmail.com>
Date: Tue, 9 Nov 2004 12:08:42 +0000
From: Rogelio Serrano <rogelio.serrano@gmail.com>
Reply-To: Rogelio Serrano <rogelio.serrano@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: mboot vmlinux
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Any progress on mboot vmlinux? Im backporting the mboot patch to
linux-1.0.9 with the memory-savers patch.
