Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932264AbWCXXk0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932264AbWCXXk0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 18:40:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932269AbWCXXk0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 18:40:26 -0500
Received: from omr2.networksolutionsemail.com ([205.178.146.52]:36524 "EHLO
	ns-omrbm2.netsolmail.com") by vger.kernel.org with ESMTP
	id S932264AbWCXXkZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 18:40:25 -0500
From: evt@texelsoft.com
To: linux-kernel@vger.kernel.org
Importance: Normal
Sensitivity: Normal
Message-ID: <W433413418255631143243608@webmail13>
X-Mailer: Mintersoft EdgeDesk, Build 4.03.0105
X-Originating-IP: [69.163.37.1]
X-Forwarded-For: [(null)]
Date: Fri, 24 Mar 2006 23:40:08 +0000
Subject: what's the right way to do this in 2.6?
Reply-to: evt@texelsoft.com
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have two modules that need to share a common utility library. What I'd like to do is make the library into a .a and link each module to it. 'Twould be also nice if the modules had a dependency so the library got built automatically. Thanks for any advice.

- Eric van Tassell


