Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266663AbUJAXIi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266663AbUJAXIi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 19:08:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266684AbUJAXIi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 19:08:38 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:53226 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S266663AbUJAXIg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 19:08:36 -0400
Subject: Re: EXT3-fs errors after going into S1
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Alexander Nyberg <alexn@dsv.su.se>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1096646879.636.27.camel@boxen>
References: <1096646879.636.27.camel@boxen>
Content-Type: text/plain
Message-Id: <1096672249.3419.4.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Sat, 02 Oct 2004 09:10:49 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I'm just back after some travel. Sorry for the slow reply.

On Sat, 2004-10-02 at 02:07, Alexander Nyberg wrote:
> Unable to find swap-space signature
> Stopping tasks: ==================|
> Back to C!
> APIC error on CPU0: 00(00)
> Restarting tasks... done
> Stopping tasks: ==================|
> Back to C!
> APIC error on CPU0: 00(00)
> Restarting tasks... done
> Stopping tasks: ========================|
> Back to C!
> APIC error on CPU0: 00(00)
> Restarting tasks... done
> Stopping tasks: ============================|
> Back to C!
> APIC error on CPU0: 00(00)
> Restarting tasks... done

This looks like S3 or swsusp. You probably want to report it to Pavel
Machek, rather than me.

Regards,

Nigel

