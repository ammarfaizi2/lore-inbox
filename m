Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266225AbUAWGef (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 01:34:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265658AbUAWGef
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 01:34:35 -0500
Received: from smtp106.mail.sc5.yahoo.com ([66.163.169.226]:33148 "HELO
	smtp106.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266225AbUAWGee (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 01:34:34 -0500
Subject: Re : Alsa create high problems...
From: Eddahbi Karim <installation_fault_association@yahoo.fr>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1074382859.29525.20.camel@gamux>
References: <1074382859.29525.20.camel@gamux>
Content-Type: text/plain
Organization: Installation Fault
Message-Id: <1074839589.8684.1.camel@gamux>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 23 Jan 2004 07:33:09 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hiya,

The bug is still there in 2.6.2-rc1 and I still need to do a :
while true; do cat /proc/asound/card0/pcm0p/sub0/*; done

To get my sound work properly...

-- 
Eddahbi Karim <installation_fault_association@yahoo.fr>
Installation Fault

