Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280629AbRKJMmC>; Sat, 10 Nov 2001 07:42:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280633AbRKJMlw>; Sat, 10 Nov 2001 07:41:52 -0500
Received: from host213-121-105-27.in-addr.btopenworld.com ([213.121.105.27]:1015
	"HELO mail.dark.lan") by vger.kernel.org with SMTP
	id <S280629AbRKJMli>; Sat, 10 Nov 2001 07:41:38 -0500
Subject: Re: 2.4.x: AT Keyboard not present?
From: Greg Sheard <greg@ecsc.co.uk>
To: Harald Dunkel <harri@synopsys.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200111091931.fA9JVXif001648@bilbo.gr05.synopsys.com>
In-Reply-To: <200111091931.fA9JVXif001648@bilbo.gr05.synopsys.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.1+cvs.2001.11.07.16.47 (Preview Release)
Date: 10 Nov 2001 12:41:01 +0000
Message-Id: <1005396061.32176.4.camel@lemsip>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2001-11-09 at 19:31, root wrote:
> Hi folks,
> 
> From time to time I experience that my mouse pointer blocks for a few 
> seconds, the stuff that I type is ignored, etc. 'grep keyboard' in my 
> syslog files returns:
> 
> Nov  2 20:27:36 bilbo kernel: keyboard: Timeout - AT keyboard not present?(ed)
<snip>
> Pretty strange, isn't it? What is the story here?
> 

I get this message (a) on boot, and (b) when shutting down X. It pops up
twice each time -- it seems to be linked to something requiring AT (or
AT emulation?) keyboard control. I'm using a USB keyboard =]

I suspect it's non-critical, but YMMV. Anyone else?

Cheers,
Greg.


