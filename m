Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261242AbVGMQnD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261242AbVGMQnD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 12:43:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262701AbVGMQkt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 12:40:49 -0400
Received: from zproxy.gmail.com ([64.233.162.201]:45427 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262699AbVGMQjO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 12:39:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=XTGTDY91nuDhTL9/DckpRvJwcQUbTAIVDa60N8lsE6eFQFTRM6LXJoV0t3LJdV9Ak2wA638KgEIGz+I/OzSo5IlFve5QOf7/zqGhqxEGvzRzR3YBPPzlhgRlvgJBVxGUWcgz8WUUunXeMw1Tla2sLltdTHK7YPJGSMRi1tBZe0M=
Message-ID: <3b0ffc1f05071309396353066b@mail.gmail.com>
Date: Wed, 13 Jul 2005 12:39:13 -0400
From: Kevin Radloff <radsaq@gmail.com>
Reply-To: Kevin Radloff <radsaq@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: ACPI processor C-state regression in 2.6.13-rc3?
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With the ACPI merge in 2.6.13-rc3, C2 and C3 processor states are no
longer detected/enabled on my Fujitsu Lifebook P7010D. Enabling ACPI
debugging doesn't result in any extra info about this being reported.
I assume it's related to the changes to enable C2/3 on SMP..

Please CC me with any followups, as I'm not on the list.

-- 
Kevin 'radsaq' Radloff
radsaq@gmail.com
http://saqataq.us/
