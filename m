Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269467AbRHCQZu>; Fri, 3 Aug 2001 12:25:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269465AbRHCQZk>; Fri, 3 Aug 2001 12:25:40 -0400
Received: from cr545978-a.nmkt1.on.wave.home.com ([24.112.25.43]:7173 "HELO
	saturn.tlug.org") by vger.kernel.org with SMTP id <S269467AbRHCQZa>;
	Fri, 3 Aug 2001 12:25:30 -0400
Date: Fri, 3 Aug 2001 12:25:39 -0400
From: Mike Frisch <mfrisch@saturn.tlug.org>
To: linux-kernel@vger.kernel.org
Subject: Re: fake loop
Message-ID: <20010803122539.A10211@saturn.tlug.org>
Mail-Followup-To: Mike Frisch <mfrisch@saturn.tlug.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010803155735.18620.qmail@nwcst31f.netaddress.usa.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010803155735.18620.qmail@nwcst31f.netaddress.usa.net>; from ailinykh@usa.net on Fri, Aug 03, 2001 at 09:57:34AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 03, 2001 at 09:57:34AM -0600, Andrey Ilinykh wrote:
> Very often I see in kernel such code as
> do {
>   dosomthing();
> } while(0);
> 
> or even
> 
> #define prepare_to_switch()     do { } while(0)
> 
> Who can explain me a reason for these fake loops?

This is answered in the Kernelnewbies FAQ @
http://kernelnewbies.org/faq/index.php3#dowhile.xml.
