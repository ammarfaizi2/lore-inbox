Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265906AbTFSTEp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 15:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265907AbTFSTEp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 15:04:45 -0400
Received: from mail.hks.com ([63.125.197.5]:33986 "EHLO mail.hks.com")
	by vger.kernel.org with ESMTP id S265906AbTFSTEo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 15:04:44 -0400
Subject: process stack question
From: Robert Schweikert <Robert.Schweikert@abaqus.com>
To: linux-kernel@vger.kernel.org
Cc: Robert Schweikert <rjschwei@abaqus.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: ABAQUS
Message-Id: <1056050322.24403.116.camel@cheetah.hks.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 19 Jun 2003 15:18:42 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been searching for some documentation on how to get at
information regarding the process stack but I didn't find much and from
what I found it was not clear to me how I could use the information.

Here is what I am after.

We have some rudimentary memory tracking tools in our application and
I'd like to put some debug output in that allows me to write the name of
the routine I am in to some debug log.

My thinking is that I should be able to get a hold of the process call
stack and using the top of the stack I should have the name of the
function/method I am in. 

Any help on how to go about this would be appreciated. A pointer to any
documentation on how to get a hold of the stack, or the public API for
this is of course welcome.

Thanks,
Robert
-- 
Robert Schweikert <Robert.Schweikert@abaqus.com>
ABAQUS
