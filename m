Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292420AbSBPQ3q>; Sat, 16 Feb 2002 11:29:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292415AbSBPQ3i>; Sat, 16 Feb 2002 11:29:38 -0500
Received: from ns.ithnet.com ([217.64.64.10]:41220 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S292414AbSBPQ3W>;
	Sat, 16 Feb 2002 11:29:22 -0500
Message-Id: <200202161629.RAA26048@webserver.ithnet.com>
Cc: linux-kernel@vger.kernel.org
Date: Sat, 16 Feb 2002 17:29:11 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
In-Reply-To: <200202161519.g1GFJij3002094@cneufeld.linuxcare.com>
Content-Transfer-Encoding: 7BIT
Subject: Re: Reproducible oops in 2.4.17, possibly related to ipchains
To: neufeld@linuxcare.com
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
User-Agent: IMHO/0.97.1 (Webmail for Roxen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have an easily reproducible oops in 2.4.17, running on an IBM     
Thinkpad                                                              
> 600E.  The system is quite stable until I add certain ipchains      
rules, after                                                          
> which time it reliably crashes within minutes.                      
                                                                      
This bug is fixed in later kernel releases. Try using 2.4.18-rc1.     
                                                                      
Regards,                                                              
Stephan                                                               
                                                                      
                                                                      
                                                                      
