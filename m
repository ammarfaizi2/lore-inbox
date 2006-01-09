Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750703AbWAITHm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750703AbWAITHm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 14:07:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750708AbWAITHm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 14:07:42 -0500
Received: from uproxy.gmail.com ([66.249.92.196]:44531 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750703AbWAITHl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 14:07:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=V7EWJz8uWIExSkQ70C/Nhvy9AdVbuUM7nbuwBHUzD9CapxpiADeHNUQuNWeUZdDWpJuQeRy3z3QLA9iv9IecU/Fpl7iamdEhzu/78BlD26BrUChTwbY3gH7B5Ujt4aQi9ZfzIh11l/7WyXIMs/qYV9Y5nup6aGyDNPJx8VdF7Po=
Date: Mon, 9 Jan 2006 20:07:28 +0100
From: Diego Calleja <diegocg@gmail.com>
To: Yaroslav Rastrigin <yarick@it-territory.ru>
Cc: s0348365@sms.ed.ac.uk, andersen@codepoet.org, linux-kernel@vger.kernel.org
Subject: Re: Why the DOS has many ntfs read and write driver,but the linux
 can't for a long time
Message-Id: <20060109200728.fc83190d.diegocg@gmail.com>
In-Reply-To: <200601091403.46304.yarick@it-territory.ru>
References: <174467f50601082354y7ca871c7k@mail.gmail.com>
	<200601091207.14939.yarick@it-territory.ru>
	<200601091022.30758.s0348365@sms.ed.ac.uk>
	<200601091403.46304.yarick@it-territory.ru>
X-Mailer: Sylpheed version 2.1.6 (GTK+ 2.8.9; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Mon, 9 Jan 2006 14:03:46 +0300,
Yaroslav Rastrigin <yarick@it-territory.ru> escribió:


> Overall performance isn't that bad, either, but I just can't understand, why KATE (Kde more or less advanced editor) takes twice as long to start 
> as UltraEdit in _emulated_ (VMWare) Windows XP running on this same box.
> 
> So, the question remains the same - whom and how much I need to pay to solve abovementioned problems ?


X.org and related freedesktop projects would be a good start. There's
a _lot_ of things that need to be done for X.org and nobody is doing
them, and they benefit all the desktops not just KDE. Fontconfig eats
1/3 of the time it takes to start a kde app (with warm caches), for
example.
