Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270614AbRHIXm2>; Thu, 9 Aug 2001 19:42:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270618AbRHIXmM>; Thu, 9 Aug 2001 19:42:12 -0400
Received: from carthage.proaxis.com ([216.65.131.35]:11655 "EHLO
	carthage.proaxis.com") by vger.kernel.org with ESMTP
	id <S270614AbRHIXl4>; Thu, 9 Aug 2001 19:41:56 -0400
Content-Type: text/plain; charset=US-ASCII
From: Ray Lischner <lisch@tempest-sw.com>
Reply-To: lisch@tempest-sw.com
Organization: Tempest Software
To: linux-kernel@vger.kernel.org
Subject: What does MAP_EXECUTABLE do?
Date: Thu, 9 Aug 2001 16:44:46 -0700
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01080916444603.27109@sycorax>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Running man mmap produces the enlightening text, "Linux also knows 
about ... MAP_EXECUTABLE ..." but does nto tell me what MAP_EXECUTABLE 
actually does, and how it differs from using PROT_EXEC. Reading the 
source code has not helped me much.
-- 
Ray Lischner (http://www.tempest-sw.com/)
