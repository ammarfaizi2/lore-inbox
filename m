Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261462AbVACOyG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261462AbVACOyG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 09:54:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261463AbVACOyG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 09:54:06 -0500
Received: from wproxy.gmail.com ([64.233.184.199]:58912 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261462AbVACOyD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 09:54:03 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=NZHeCSRMmEofG0jABwSv5miEI+Dl//0YYG1SAyihhpzqrmDLyWqaqkVY3ZmB7T/pWfaWY+80gPORA2VBbNJfQ7Ak/3n2czxFNUUoVRUO2tPIngC2cCWkZkkUZz+hMN3IGE/VvKgQtKM9t0gcnqtOhGgLKCREbHtCDs8cN5rhyGg=
Message-ID: <5545708d050103065473670d7b@mail.gmail.com>
Date: Mon, 3 Jan 2005 09:54:03 -0500
From: Michael Gay <mike2post@gmail.com>
Reply-To: Michael Gay <mike2post@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: System hang on startup.
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello-

My system hangs on startup at the following prompt:

checking file systems
/dev/sda: recovering journal

I have tried letting it just sit there and "recover" for 2 hours at
first and then for 24 hours with still no luck. Does anyone have any
ideas? And/or does anyone know the severity of this problem?

-Michael
