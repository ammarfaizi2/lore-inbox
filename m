Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281890AbRK1MDW>; Wed, 28 Nov 2001 07:03:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282133AbRK1MDN>; Wed, 28 Nov 2001 07:03:13 -0500
Received: from dobit2.rug.ac.be ([157.193.42.8]:45026 "EHLO dobit2.rug.ac.be")
	by vger.kernel.org with ESMTP id <S282128AbRK1MDI>;
	Wed, 28 Nov 2001 07:03:08 -0500
Date: Wed, 28 Nov 2001 13:03:06 +0100 (MET)
From: Frank Cornelis <Frank.Cornelis@rug.ac.be>
To: <linux-kernel@vger.kernel.org>
cc: <Frank.Cornelis@rug.ac.be>
Subject: task_struct.mm == NULL
Message-ID: <Pine.GSO.4.31.0111281300070.8642-100000@eduserv.rug.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

I found in some code checks for task_struct.mm being NULL.
When can task_struct.mm of a process be NULL except right before the
process-kill?

Frank.

