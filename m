Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261192AbVCQU1Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261192AbVCQU1Y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 15:27:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261462AbVCQU1X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 15:27:23 -0500
Received: from wproxy.gmail.com ([64.233.184.194]:4900 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261192AbVCQU1V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 15:27:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=IOcNc9hzfhUUz7LGG0vFLu2zRyIIkXMpj8z5Cc5TvqPOSQzGg3CzpQTd1NJWVmByHWcRz9TTtwGn/sXVzDJ1k0W3mgPG96ZN52plzJ2OaIItF4xcUjA91WQpW4ZjxyR3QRvYMtwLMusFvQOEPDNkTnF9XZFziepvgW+lUXNR1KQ=
Message-ID: <17d7988050317122755d6958b@mail.gmail.com>
Date: Thu, 17 Mar 2005 15:27:20 -0500
From: Allison <fireflyblue@gmail.com>
Reply-To: Allison <fireflyblue@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: linux: detect application crash
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Several times when I worked with Windows, I have had a scenario when I
am editing a file and saved some time ago and then the application
crashes and I lose all recent data.

Can the operating system detect all application crashes ? If so, why
can't the OS save the user data to disk before the application quits ?

How does this work in Linux. I was curious if such a functionality
already exists in Linux. If not, what are the issues involved in
implementing this functionality.

thanks
Allison
